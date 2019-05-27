package gradle.cucumber

class RemoteStorageEntryPoint{
    fun start(){
        println("Iniciando Remote Storage...")
    }
}

fun main(args : Array<String>) {
    RemoteStorageEntryPoint().start()
}