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
                              defaultRootPath : String = "C:\\Users\\Public\\RStorage" ) {

    var rootDir : Path = initializeDirectoryStructure(defaultRootPath)

    fun run(){
        outputManager.printLine("Iniciando Remote Storage...\n")
        listFiles()
        outputManager.printLine("\nCerrando Remote Storage...")
    }

    fun initializeDirectoryStructure(defaultRootPath: String) : Path {
        val rootPath = initializeDirectory(defaultRootPath)
        initializeDirectory(defaultRootPath + File.separator + "input")
        initializeDirectory(defaultRootPath + File.separator + "output")
        return rootPath
    }

    private fun initializeDirectory(pathString : String) : Path {
        val path = Paths.get(pathString)
        try {
            Files.createDirectory(path)
        } catch (e: FileAlreadyExistsException) { /* Do Nothing */
        } catch (e: IOException) {//something else went wrong
            e.printStackTrace()
        }
        return path
    }

    @Throws(IOException::class)
    private fun listFiles() = Files.walkFileTree(rootDir, ListFilesInDirectory(outputManager))

}


fun main(args : Array<String>) {
    RemoteStorageEntryPoint().run()
}