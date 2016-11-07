var Aciton = function() {};
Aciton.prototype = {
    run: function(parameters) {
        parameters.completionFunction({"URL": document.URL, "title": document.title });
    },
    finalize: function(parameters) {
    }
};
var ExtensionPreprocessingJS = new Aciton
