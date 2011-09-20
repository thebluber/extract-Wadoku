#encoding: utf-8
#myinsert dupliziert den Array
class Array
	def myinsert(pos, el)
		self.dup.insert(pos, el)
	end
end

module Wadoku

#seperiert Teil vom Eintrag mit dem gegebenen Index nach dem gegebenen Regex
def sep(entry, index, regex)
	entry.split("\t")[index].scan(regex).flatten
end

#filtert die Index raus
def filter_index entry
	filter_regex = /(\[.+?\]|<Prior.+?>|<JLPT.+?>|<GENKI.+?>|<LangNiv.+?>|<Usage.+?>|<JWD.+?>|<Jap.+?>|<DaID.+?>|<Etym.+?>|\(<Ref.+?>\))/
 	entry.gsub(filter_regex, "")
end

#generiert einen Eintrag
def generate entry
	filtered_entry = filter_index entry
	e_array = filtered_entry.split("\t")
	kana = e_array[3] ? 3 : 2
	rest = e_array.values_at(0,kana)

	writings = sep(filtered_entry , 1, /[^;\(\)]+/)
	tres = sep(filtered_entry, 4, /(?:<TrE:){1,}(.*?)(?=>>>|>;|>\. |>\ \/)/)
#.map{|tre| tre.end_with?(">") ? tre : tre + ">"}

	acc = []
	writings.each do |w|
		tres.each{|tre| acc = acc << rest.myinsert(1, w).myinsert(4, tre).join("\t").gsub("\t\t", "\t")}
	end
	return acc
end


#Datei extrahieren und in eine neue Datei schreiben
def extract(wdk_raw, wdk_new)
	content = File.readlines(wdk_raw).drop(1)
	new_content = content.map{|entry| generate entry}.flatten.join("\n")
	file = File.new(wdk_new, "w")
	file.puts new_content
	file.close
end

HW_regex = /(<HW.+?: )|(>)(?!\)|“)/
end
