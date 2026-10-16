//linker, parses the JSON and knows which links go from input to output
import vibe.vibe;
import std.file : readText;
import std.stdio;
import std.json;
import std.file;
class Linker{
string jsonParseForTargets(string cute_slug){
    //apparently I couldnt just load these out of a method. Fuck D.
    string the_json_with_links = readText("public/links.json");
JSONValue root = parseJSON(the_json_with_links);
        try{
        foreach (item; root.array){
            if(cute_slug==item["to"].str){
                return item["fro"].str;
            }
        }
        }
        catch(Exception e){
            writeln("something bwokie... " ~ e.toString());
        }
        return "";
}
bool addNewLinkToTheJson(string cute_slug, string target, string passowrd){
        //apparently I couldnt just load these out of a method. Fuck D.
    string the_json_with_links = readText("public/links.json");
JSONValue root = parseJSON(the_json_with_links);
    bool foundCute_SlugThatAlreadyExists = false;
    foreach (ref item; root.array){
        if(cute_slug == item["to"].str){
            if("pass" in item && item["pass"].str != passowrd) {
                return false;
            }
            item["fro"] = target;
            item["pass"] = passowrd;
            foundCute_SlugThatAlreadyExists = true;
        }
    }
    if(foundCute_SlugThatAlreadyExists == false){
        root.array ~= JSONValue(["to": cute_slug, "fro": target, "pass": passowrd]);
    }
    std.file.write("public/links.json", root.toPrettyString());
    return true;
}
}

