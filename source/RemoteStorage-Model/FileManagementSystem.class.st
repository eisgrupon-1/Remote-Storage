Class {
	#name : #FileManagementSystem,
	#superclass : #SubsystemImplementation,
	#instVars : [
		'files'
	],
	#category : #'RemoteStorage-Model-Core'
}

{ #category : #initialization }
FileManagementSystem >> deleteFileNamed: aFileName [
	self getAllFiles
		detect: [ :file | file name = aFileName ]
		ifFound: [ :file | 
			| fileRelativePath |
			fileRelativePath := self remoteStorageFolderName , '/' , aFileName.
			(FileStream fileNamed: fileRelativePath) delete.
			files remove: file ]
		ifNone: [ "Do nothing" ]
]

{ #category : #installing }
FileManagementSystem >> dependencies [
	^ #()
]

{ #category : #initialization }
FileManagementSystem >> ensureRemoteStorageDirectoryExists [
	self remoteStorageDirectoryReference ensureCreateDirectory
]

{ #category : #initialization }
FileManagementSystem >> fileIdentifiedBy: anUUID ifFound: aFoundBlock ifNone: aNoneBlock [
	^ self getAllFiles
		detect: [ :file | file uuid = anUUID ]
		ifFound: aFoundBlock
		ifNone: aNoneBlock
]

{ #category : #initialization }
FileManagementSystem >> getAllFiles [
	self updateFiles.
	^ files
]

{ #category : #installing }
FileManagementSystem >> implementedInterfaces [
	^ #(#FileManagementSystemInterface)
]

{ #category : #initialization }
FileManagementSystem >> initialize [
	super initialize.
	self
		ensureRemoteStorageDirectoryExists;
		initializeFiles
]

{ #category : #initialization }
FileManagementSystem >> initializeFiles [

	files := (self remoteStorageDirectoryReference allFiles
		collect: [ :file | RSFile from: file ]) asOrderedCollection
]

{ #category : #accessing }
FileManagementSystem >> name [
	^ 'Sistema de manejo de archivos'
]

{ #category : #initialization }
FileManagementSystem >> remoteStorageDirectoryReference [
	^ (Path from: './' , self remoteStorageFolderName) asFileReference
]

{ #category : #initialization }
FileManagementSystem >> remoteStorageFolderName [
	^ 'RSFiles'
]

{ #category : #initialization }
FileManagementSystem >> updateFiles [
	| filesToRemove |
	filesToRemove := OrderedCollection new.
	self remoteStorageDirectoryReference allFiles
		do: [ :file | 
			((files collect: #name)
				anySatisfy: [ :fileName | fileName = file pathSegments last ])
				ifFalse: [ files add: (RSFile from: file) ] ].
	((files collect: #name)
		difference:
			(self remoteStorageDirectoryReference allFiles
				collect: [ :file | file pathSegments last ]))
		do: [ :missingName | 
			files
				detect: [ :file | file name = missingName ]
				ifFound: [ :file | filesToRemove add: file ]
				ifNone: [  ] ].
	filesToRemove do: [ :file | files remove: file ]
]

{ #category : #initialization }
FileManagementSystem >> writeFileNamed: aFileName withContents: aByteArray [
	| newFileRelativePath |
	newFileRelativePath := self remoteStorageFolderName , '/' , aFileName.
	FileStream
		newFileNamed: newFileRelativePath
		do: [ :fileStream | 
			fileStream
				nextPutAll: aByteArray;
				close ].
	^ RSFile
		from: (Path from: './' , newFileRelativePath) asFileReference
]
