Class {
	#name : #FileManagementSystem,
	#superclass : #SubsystemImplementation,
	#category : #'RemoteStorage-Model-Core'
}

{ #category : #installing }
FileManagementSystem >> dependencies [
	^ #()
]

{ #category : #installing }
FileManagementSystem >> implementedInterfaces [
	^ #(#FileManagementSystemInterface)
]

{ #category : #accessing }
FileManagementSystem >> name [
	^ 'Sistema de manejo de archivos'
]
