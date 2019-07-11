/* 
Copyright (c) 2019 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
import ObjectMapper

struct Tv : Mappable {
	var original_name : String?
	var genre_ids : [Int]?
	var name : String?
	var popularity : Double?
	var origin_country : [String]?
	var vote_count : Int?
	var first_air_date : String?
	var backdrop_path : String?
	var original_language : String?
	var id : Int?
	var vote_average : Double?
	var overview : String?
	var poster_path : String?
    
	init?(map: Map) {

	}

	mutating func mapping(map: Map) {

		original_name <- map["original_name"]
		genre_ids <- map["genre_ids"]
		name <- map["name"]
		popularity <- map["popularity"]
		origin_country <- map["origin_country"]
		vote_count <- map["vote_count"]
		first_air_date <- map["first_air_date"]
		backdrop_path <- map["backdrop_path"]
		original_language <- map["original_language"]
		id <- map["id"]
		vote_average <- map["vote_average"]
		overview <- map["overview"]
		poster_path <- map["poster_path"]
	}

}
