/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct MovieDetail : Mappable {
	var adult : Bool?
	var backdrop_path : String?
	var belongs_to_collection : String?
	var budget : Int?
	var genres : [Genres]?
	var homepage : String?
	var id : Int?
	var imdb_id : String?
	var original_language : String?
	var original_title : String?
	var overview : String?
	var popularity : Double?
	var poster_path : String?
	var production_companies : [Production_companies]?
	var production_countries : [Production_countries]?
	var release_date : String?
	var revenue : Int?
	var runtime : Int?
	var spoken_languages : [Spoken_languages]?
	var status : String?
	var tagline : String?
	var title : String?
	var video : Bool?
	var vote_average : Double?
	var vote_count : Int?
    
    var isFavSelected : Bool = false

	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		adult <- map["adult"]
		backdrop_path <- map["backdrop_path"]
		belongs_to_collection <- map["belongs_to_collection"]
		budget <- map["budget"]
		genres <- map["genres"]
		homepage <- map["homepage"]
		id <- map["id"]
		imdb_id <- map["imdb_id"]
		original_language <- map["original_language"]
		original_title <- map["original_title"]
		overview <- map["overview"]
		popularity <- map["popularity"]
		poster_path <- map["poster_path"]
		production_companies <- map["production_companies"]
		production_countries <- map["production_countries"]
		release_date <- map["release_date"]
		revenue <- map["revenue"]
		runtime <- map["runtime"]
		spoken_languages <- map["spoken_languages"]
		status <- map["status"]
		tagline <- map["tagline"]
		title <- map["title"]
		video <- map["video"]
		vote_average <- map["vote_average"]
		vote_count <- map["vote_count"]
	}

}
