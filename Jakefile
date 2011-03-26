
var FILE = require("file"),
    ENV  = require("system").env,
    Jake = require("jake"),
    task = Jake.task,
    FileList = Jake.FileList,
    bundle = require("objective-j/jake").bundle,
    framework = require("objective-j/jake").framework,
    environment = require("objective-j/jake/environment");

$CONFIGURATION = ENV['CONFIG'] || "Release";

$BUILD_DIR = ENV['CAPP_BUILD'] || ENV['STEAM_BUILD'];

bundle ("AldrinKit", function(task)
{
    task.setBuildIntermediatesPath(FILE.join($BUILD_DIR, "AldrinKit.build", $CONFIGURATION))
    task.setBuildPath(FILE.join($BUILD_DIR, $CONFIGURATION));

    task.setAuthor("Aldrin Martoq");
    task.setEmail("aldrin @nospam@ martoq.cl");
    task.setSummary("Utilities framework for Cappucino");
    task.setIdentifier("cl.martoq.cappuccino.AldrinKit");
    task.setSources(new FileList("*.j").exclude("AldrinKitPlugin.j").exclude("GoogleMapsViewAttributeInspector.j").exclude("GoogleMapsView+Integration.j"), [environment.Browser, environment.CommonJS]);
    task.setResources([]);//All the resources belong to the plugin
    task.setFlattensSources(true);

    if ($CONFIGURATION === "Release")
        task.setCompilerFlags("-O");
    else
        task.setCompilerFlags("-DDEBUG -g");
});

framework ("AldrinKit.atlasplugin", function(task)
{
    task.setBuildIntermediatesPath(FILE.join($BUILD_DIR, "AldrinKit.atlasplugin.build", $CONFIGURATION))
    task.setBuildPath(FILE.join($BUILD_DIR, $CONFIGURATION));

    task.setAuthor("Aldrin Martoq");
    task.setEmail("aldrin @nospam@ martoq.cl");
    task.setSummary("AldrinKit Plugin for Atlas");
    task.setIdentifier("cl.martoq.cappuccino.AldrinKit.atlas");
    task.setInfoPlistPath("PluginInfo.plist");
    task.setSources(new FileList("*.j"), [environment.Browser, environment.CommonJS]);
    task.setResources(new FileList("Resources/*"));
    task.setNib2CibFlags("-F " + FILE.join(FILE.join($BUILD_DIR, $CONFIGURATION), "AtlasKit") + " -R Resources");
    task.setPrincipalClass("AldrinKitPlugin");
    task.setFlattensSources(true);

    if ($CONFIGURATION === "Release")
        task.setCompilerFlags("-O");
    else
        task.setCompilerFlags("-DDEBUG -g");
});

task ("build", ["AldrinKit", "AldrinKit.atlasplugin"]);
task ("default", ["build"]);
