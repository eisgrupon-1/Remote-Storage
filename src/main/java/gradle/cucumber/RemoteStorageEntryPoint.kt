package gradle.cucumber

import gradle.cucumber.outputManagement.ConsoleOutputManager
import gradle.cucumber.outputManagement.OutputManager
import java.io.File
import java.nio.file.Files
import java.nio.file.Path
import java.nio.file.Paths
import java.io.IOException
import java.nio.file.FileAlreadyExistsException

class RemoteStorageEntryPoint(val outputManager : OutputManager = ConsoleOutputManager(),
                              defaultRootString : String = "C:\\Users\\Public\\RStorage" ) {

    var rootDir : Path
    var inputDir : Path
    var outputDir : Path

    init {
        rootDir = initializeDirectory(defaultRootString)
        inputDir = initializeDirectory(defaultRootString + File.separator + "input")
        outputDir = initializeDirectory(defaultRootString + File.separator + "output")
    }

    fun run(){
        outputManager.printLine("Iniciando Remote Storage...\n")
        listFiles()
        outputManager.printLine("\nCerrando Remote Storage...")
    }


    private fun initializeDirectory(pathString : String) : Path {
        var path = Paths.get(pathString)
        try {
            Files.createDirectory(path)
        } catch (e: FileAlreadyExistsException) { /* Do Nothing */
        } catch (e: IOException) {//something else went wrong
            e.printStackTrace()
        }
        return path
    }

    private fun listFiles(){
        try {
            Files.walkFileTree(rootDir, ListFilesInDirectory(outputManager))
        } catch (e: IOException) {
            e.printStackTrace()
        }
    }
}


fun main(args : Array<String>) {
    RemoteStorageEntryPoint().run()
}