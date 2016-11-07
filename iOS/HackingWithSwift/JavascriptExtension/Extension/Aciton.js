var Aciton = function() {};
Aciton.prototype = {
    run: function(parameters) {
        parameters.completionFunction({"URL": document.URL, "title": document.title });
    },
    finalize: function(parameters) {
        var customJavaScript = parameters["customJavaScript"];
        eval(customJavaScript);
        //can test witih alert(document.title)
    }
};
var ExtensionPreprocessingJS = new Aciton
