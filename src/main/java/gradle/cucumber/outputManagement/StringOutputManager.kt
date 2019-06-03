package gradle.cucumber.outputManagement

class StringOutputManager(var output : String = "") : OutputManager() {

    override fun printLine(string : String) { output += string + "\n" }
    override fun printString(character : Char) { output += character }

    fun getOutputString() : String { return output }
}