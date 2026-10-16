
import vibe.vibe;
import std.file : readText;
import linker;

void main()
{
    Linker linker = new Linker();
    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.bindAddresses = ["127.0.0.1"];

    auto router = new URLRouter;
    router.get("/", delegate void(HTTPServerRequest req, HTTPServerResponse res) {
        res.redirect("/index");
    });
    router.get("/index", delegate void(HTTPServerRequest req, HTTPServerResponse res) {
    res.writeBody(readText("public/index.html"), "text/html");});
    router.get("/testing", delegate void(HTTPServerRequest req, HTTPServerResponse res) {
        res.writeBody("yes it works :)");
    });
    router.get("/:cute_slug", delegate void(HTTPServerRequest req, HTTPServerResponse res) {
        string target = linker.jsonParseForTargets(req.params["cute_slug"]);
        if(target.length==0){ 
        res.writeBody("error, unknown page: " ~ req.params["cute_slug"]);}
        else if(target.length>0){
            res.redirect(target);
        }
        else{
            res.writeBody("JSON database appears to be missing?");
        }
    });
    router.post("/api/create", delegate void(HTTPServerRequest req, HTTPServerResponse res) {
    auto bodydajson = req.json;
    string cute_slug = bodydajson["to"].get!string();
    string target = bodydajson["fro"].get!string();
    string pass = bodydajson["pass"].get!string();
    bool success = linker.addNewLinkToTheJson(cute_slug, target, pass);
    if (success) {
        res.writeJsonBody(["status": "success"]);
    } else {
        res.statusCode = 403;
        res.writeJsonBody(["status": "wrong_password"]);
    }
});
    listenHTTP(settings, router);
    runApplication();
}
