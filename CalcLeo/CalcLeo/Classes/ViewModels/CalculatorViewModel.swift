import Foundation
import DatabaseLeo
import MathLogicLeo
import NetworkLeo
import CodableLeo

protocol CalculatorViewModelDelegate: AnyObject {
    func dataUpdated(with models: [[Feature]])
    func publishError(_ error: Error)
    func updateResult(with text: String)
}

final class CalculatorViewModel {

    weak var delegate: CalculatorViewModelDelegate?
    private var models: [[Feature]]? {
        didSet {
            guard let models = models else { return }
            delegate?.dataUpdated(with: models)
        }
    }
    private var currentBtcPrice: Float?

    private lazy var databaseManager: DatabaseManager = {
        return DatabaseManager(fileName: "Features", fileExtension: "plist", bundlePath: Bundle(for: type(of: self)).bundlePath)
    }()

    private lazy var mathLogic: MathLogic = {
        let mathLogic = MathLogic(maxDisplayValueLength: 10)
        return mathLogic
    }()

    private lazy var requestService: RequestService  = {
        let requestService = RequestService()
        return requestService
    }()

    private lazy var plistObjectMappingManager = PlistObjectMappingManager<[[Feature]]>()
    private lazy var jsonObjectMappingManager = JsonObjectMappingManager<OnlineResponse>()

    init(delegate: CalculatorViewModelDelegate?) {
        self.delegate = delegate
    }

    func prepareObjects() throws {
        let data = try databaseManager.readData()
        self.models = try plistObjectMappingManager.decode(data)
    }

    func prepareOnlineData(with cryptoCurrency: String, callback: @escaping (Result<Float, Error>) -> Void) throws {
        let stringURL = "https://api.coindesk.com/v1/bpi/currentprice/" + cryptoCurrency

        try requestService.requestData(with: stringURL) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                do {
                    let response = try self.jsonObjectMappingManager.decode(data)
                    callback(.success(response.bpi.USD.rate_float))
                } catch {
                    callback(.failure(error))
                }
            case .failure(let error): callback(.failure(error))
            }
        }
    }

    func buttonTap(with id: Int) throws {
        guard let models = models else { return }
        guard let element = (models.joined().first { $0.id == id }) else { return }

        if element.type == .online {
            try prepareOnlineData(with: element.value) { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let value):
                    do {
                        let _ = try self.mathLogic.processInput("*")
                        let result = try self.mathLogic.processInput(String(value))
                        self.delegate?.updateResult(with: result)
                    } catch {
                        self.delegate?.publishError(error)
                    }
                case .failure(let error): self.delegate?.publishError(error)
                }
            }
        } else {
            let result = try mathLogic.processInput(element.value)
            delegate?.updateResult(with: result)
        }
    }
}
