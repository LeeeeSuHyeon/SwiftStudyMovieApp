//
//  ViewController.swift
//  Movie


import UIKit
let name = ["aa","bb","cc","dd","ee"]
// https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=9e8bb4ba542836f87361a78925f7775b&targetDt=20220720
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var table: UITableView!
    let movieURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=9e8bb4ba542836f87361a78925f7775b&targetDt=20220720"
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getData()
        // Do any additional setup after loading the view.
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
                let dataSting = String(data: JSONdata, encoding: .utf8)
                print(dataSting!)
            }
        }
            task.resume()
    }
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! MyTableViewCell
        cell.movieName.text = name[indexPath.row]//indexPath.description
        return cell
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.description)
    }

}

