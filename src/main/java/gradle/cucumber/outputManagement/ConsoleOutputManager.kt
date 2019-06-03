package gradle.cucumber.outputManagement

class ConsoleOutputManager : OutputManager() {

    override fun printLine(string : String) = println(string)
    override fun printString(character : Char) = print(character)

}