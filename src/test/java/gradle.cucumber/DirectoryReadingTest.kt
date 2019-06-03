package gradle.cucumber

import gradle.cucumber.outputManagement.StringOutputManager
import org.junit.Test
import org.junit.jupiter.api.Assertions.assertEquals
import org.junit.jupiter.api.Assertions.assertTrue
import java.io.File

class DirectoryReadingTest{

    @Test
    fun testOutputForJustCreatedDirectoriesIsEmpty(){
        var outputManager = StringOutputManager()
        assertTrue(outputManager.getOutputString().isEmpty())

       RemoteStorageEntryPoint(outputManager,
                File( "." ).getCanonicalPath() + File.separator + "RStorage").run()

        assertEquals("Iniciando Remote Storage...\n\n" +
                        "Started to traversing: RStorage\n" +
                        "   Started to traversing: input\n" +
                        "   Finished traversing: input\n" +
                        "   Started to traversing: output\n" +
                        "   Finished traversing: output\n" +
                        "Finished traversing: RStorage\n" +
                        "\nCerrando Remote Storage...\n",
                outputManager.getOutputString())
    }


}