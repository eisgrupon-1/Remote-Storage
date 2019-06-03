package gradle.cucumber.outputManagement

abstract class OutputManager(private val indentationAmount : Int = 3, private var indentationLevel : Int = 0) {

    abstract fun printLine(string : String)
    abstract fun printString(character : Char)

    fun indent() {
        for (i in 0 until indentationLevel)
            printString(' ')
    }

    fun addIndent(){
        indentationLevel += indentationAmount
    }

    fun reduceIndent(){
        indentationLevel -= indentationAmount
    }

}