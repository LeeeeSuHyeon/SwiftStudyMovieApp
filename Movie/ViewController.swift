//
//  ViewController.swift
//  Movie


import UIKit
// let name = ["aa","bb","cc","dd","ee"]
struct MovieData : Codable {
    let boxOfficeResult : BoxOfficeResult
}
struct BoxOfficeResult : Codable{
    let dailyBoxOfficeList :  [DailyBoxOfficeList]
}
struct DailyBoxOfficeList : Codable{
    let movieNm : String
    let audiCnt : String
}
// https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=9e8bb4ba542836f87361a78925f7775b&targetDt=20220720
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    var movieData : MovieData?
    var movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=9e8bb4ba542836f87361a78925f7775b&targetDt=" //20220805"
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        movieURL += makeYesterdayString()
        getData()
        // Do any additional setup after loading the view.
    }
    func makeYesterdayString() -> String{
        let yesterDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyymmdd"
        return formatter.string(from: yesterDay)
        
        
    }
    func getData(){
        if let url = URL(string: movieURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil{
                print(error!)
                return
            }
            if let JSONdata = data{
                //print(JSONdata)
                //let dataString = String(data: JSONdata, encoding: .utf8)
                //print(dataString!)
                let decoder = JSONDecoder()
                do{
                let decodedData = try decoder.decode(MovieData.self, from: JSONdata)
//                    print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
//                    print(decodedData.boxOfficeResult.dailyBoxOfficeList[0].audiCnt)
//                    print(decodedData.boxOfficeResult.dailyBoxOfficeList[1].movieNm)
//                    print(decodedData.boxOfficeResult.dailyBoxOfficeList[1].audiCnt)
                    self.movieData = decodedData
                    
                    DispatchQueue.main.async {
                        self.table.reloadData()
                    }
                }catch{
                    print(error)
                }
            }
        }
            task.resume()
    }
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.movieName.text = movieData?.boxOfficeResult.dailyBoxOfficeList[indexPath.row].movieNm
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }

}

