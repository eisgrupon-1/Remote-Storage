package gradle.cucumber

import gradle.cucumber.outputManagement.OutputManager
import java.nio.file.Path
import java.nio.file.SimpleFileVisitor

import java.io.IOException
import java.nio.file.FileVisitResult
import java.nio.file.attribute.BasicFileAttributes

class ListFilesInDirectory(val outputManager : OutputManager) : SimpleFileVisitor<Path>() {

    //Hacemos print y println por ahora para ver el resultado en consola.


    override fun visitFile(file: Path, attributes: BasicFileAttributes): FileVisitResult {
        outputManager.indent()
        outputManager.printLine("file:" + file.fileName)
        return FileVisitResult.CONTINUE
    }

    @Throws(IOException::class)
    override fun preVisitDirectory(directory: Path,
                                   attributes: BasicFileAttributes): FileVisitResult {
        outputManager.indent()
        outputManager.printLine("Start to traverse: " + directory.fileName)
        outputManager.addIndent()
        return FileVisitResult.CONTINUE
    }

    @Throws(IOException::class)
    override fun postVisitDirectory(directory: Path, e: IOException?): FileVisitResult {
        outputManager.reduceIndent()
        outputManager.indent()
        outputManager.printLine("Finished traversing: " + directory.fileName)
        return FileVisitResult.CONTINUE
    }

    @Throws(IOException::class)
    override fun visitFileFailed(file: Path, exc: IOException?): FileVisitResult {
        outputManager.printLine("A file traversal error ocurred")
        return super.visitFileFailed(file, exc)
    }
}