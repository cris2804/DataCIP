allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Asegurar compileSdk para módulos de plugins (librerías) y apps de terceros
// (Debe ejecutarse temprano durante la configuración)
subprojects {
    // Para módulos tipo Library
    plugins.withType(com.android.build.gradle.LibraryPlugin::class.java) {
        extensions.configure<com.android.build.gradle.LibraryExtension>("android") {
            @Suppress("DEPRECATION")
            this.compileSdkVersion(34)
        }
    }
    // Para módulos tipo Application (si existiesen en subproyectos)
    plugins.withType(com.android.build.gradle.AppPlugin::class.java) {
        extensions.configure<com.android.build.gradle.AppExtension>("android") {
            @Suppress("DEPRECATION")
            this.compileSdkVersion(34)
        }
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

// Nota: Evitamos usar afterEvaluate (incompatible con versiones recientes de Gradle/AGP)
// Cada módulo Android (app y plugins) debe declarar su propio compileSdk.
// Flutter ya inyecta compileSdk a través de `flutter.compileSdkVersion` en :app.

 

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

// Workaround: some plugin modules (in pub cache) may lack an Android `namespace` in their
// build.gradle which causes AGP failures on recent AGP versions. Set a safe default
// namespace for library modules that don't declare one.
subprojects {
    // Configure library plugins when they are applied
    plugins.withType(com.android.build.gradle.LibraryPlugin::class.java) {
        try {
            configure<com.android.build.gradle.LibraryExtension> {
                // If namespace is null/blank, set a default based on project name
                if (this.namespace.isNullOrBlank()) {
                    this.namespace = "dev.flutter.plugins.${project.name.replace('-', '_')}"
                }
            }
        } catch (e: Exception) {
            // Don't fail the configuration phase if something unexpected occurs
            logger.warn("Could not set default namespace for project ${project.path}: ${e.message}")
        }
    }
}

// Additional workaround: some plugins still set the `package` attribute in their
// source AndroidManifest.xml which is not supported by modern AGP when namespace
// is provided. For the known problematic plugin (isar_flutter_libs) remove that
// attribute at configuration time so AGP doesn't fail.
subprojects {
    if (project.name.contains("isar_flutter_libs")) {
        val manifest = project.file("src/main/AndroidManifest.xml")
        if (manifest.exists()) {
            try {
                val original = manifest.readText()
                val fixed = original.replace(Regex("package=\"[^\"]*\""), "")
                if (original != fixed) {
                    manifest.writeText(fixed)
                    logger.lifecycle("Patched AndroidManifest.xml for ${project.path} (removed package= attribute)")
                }
            } catch (e: Exception) {
                logger.warn("Could not patch AndroidManifest for ${project.path}: ${e.message}")
            }
        }
    }
}
