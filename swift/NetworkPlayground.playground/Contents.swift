import UIKit

var str = "Hello, playground"

func fetchRepositories(_ query: String, _ completion: @escaping (Result<Repositories, NSError>) -> Void) {
    var components = URLComponents(url: Url.searchRepositories, resolvingAgainstBaseURL: true)
    components?.queryItems = [URLQueryItem(name: "q", value: query)]
    guard let url = components?.url else { return }
    let client = APIClient()
    client.get(url) { result in
        switch result {
        case .success(let data):
            do {
                let response = try JSONDecoder().decode(Repositories.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(NSError(domain: "", code: NSURLErrorCannotParseResponse, userInfo: nil)))
            }
        case .failure(let error):
            completion(.failure(error))
        }
    }
}

struct APIClient {
    func get(_ url: URL, completion: @escaping (Result<Data, NSError>) -> Void) {
        let config: URLSessionConfiguration = URLSessionConfiguration.default
        let session: URLSession = URLSession(configuration: config)
        let task: URLSessionDataTask = session.dataTask(with: url) { (data, response, error) -> Void in
            if let error = error {
                completion(.failure(error as NSError))
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                completion(.success(data))
            }
        }
        task.resume()
    }
}

private struct Url {
    static let searchRepositories: URL = URL(string: "https://api.github.com/search/repositories")!
}

struct Repository: Codable {
    let fullName: String
    let stargazersCount: Int
    let htmlUrl: String
    let owner: RepositoryOwner

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case stargazersCount = "stargazers_count"
        case htmlUrl = "html_url"
        case owner
    }

    init(fullName: String, stargazersCount: Int, htmlUrl: String, owner: RepositoryOwner) {
        self.fullName = fullName
        self.stargazersCount = stargazersCount
        self.htmlUrl = htmlUrl
        self.owner = owner
    }
}

struct RepositoryOwner: Codable {
    let avatarUrl: String

    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }

    init(avatarUrl: String) {
        self.avatarUrl = avatarUrl
    }
}

struct Repositories: Codable {
    let items: [Repository]
}

fetchRepositories("swift") { result in
    switch result {
    case .success(let repositories):
        print(repositories)
    case .failure(let error):
        print(error.description)
    }
}
