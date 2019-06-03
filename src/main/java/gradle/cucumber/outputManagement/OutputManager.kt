package gradle.cucumber.outputManagement

import java.nio.file.Path

abstract class OutputManager(private val indentationAmount : Int = 3, private var indentationLevel : Int = 0) {

    abstract fun printLine(string : String)
    abstract fun printString(character : Char)

    private fun indent() {
        for (i in 0 until indentationLevel)
            printString(' ')
    }

    private fun addIndent(){
        indentationLevel += indentationAmount
    }

    private fun reduceIndent(){
        indentationLevel -= indentationAmount
    }

    fun visitFile(file : Path) {
        indent()
        printLine("file:" + file.fileName)
    }

    fun preVisitDirectory(directory : Path) {
        indent()
        printLine("Started to traversing: " + directory.fileName)
        addIndent()
    }

    fun postVisitDirectory(directory : Path) {
        reduceIndent()
        indent()
        printLine("Finished traversing: " + directory.fileName)
    }

}