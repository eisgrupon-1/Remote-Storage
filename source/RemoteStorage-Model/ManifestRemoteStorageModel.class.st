Class {
	#name : #ManifestRemoteStorageModel,
	#superclass : #PackageManifest,
	#category : #'RemoteStorage-Model-Manifest'
}

{ #category : #'class initialization' }
ManifestRemoteStorageModel class >> initialize [
	<ignoreForCoverage>
	Kepler
		registerInterfaceAt: #FileManagementSystemInterface
		named: 'Sistema de manejo de archivos'
		declaring: #()
]
