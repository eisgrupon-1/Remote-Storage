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
        var storageEntryPoint = RemoteStorageEntryPoint(outputManager,
                File( "." ).getCanonicalPath() + File.separator + "RStorage")

        assertTrue(outputManager.getOutputString().isEmpty())
        storageEntryPoint.run()
        assertEquals("Iniciando Remote Storage...\n\n" +
                        "Start to traverse: RStorage\n" +
                        "   Start to traverse: input\n" +
                        "   Finished traversing: input\n" +
                        "   Start to traverse: output\n" +
                        "   Finished traversing: output\n" +
                        "Finished traversing: RStorage\n" +
                        "\nCerrando Remote Storage...\n",
                outputManager.getOutputString())
    }


}