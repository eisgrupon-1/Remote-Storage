Class {
	#name : #RSFileTests,
	#superclass : #TestCase,
	#instVars : [
		'fileManagementSystem'
	],
	#category : #'RemoteStorage-Tests-Core'
}

{ #category : #tests }
RSFileTests >> createExampleFile [
	fileManagementSystem
		writeFileNamed: 'example.txt'
		withContents: #(1 2 3 4 5 6 7 8 9 0 1 2 3 4 5) asByteArray
]

{ #category : #tests }
RSFileTests >> deleteExampleFile [
	fileManagementSystem deleteFileNamed: 'example.txt'
]

{ #category : #tests }
RSFileTests >> setUp [
	fileManagementSystem := FileManagementSystem new.
	self createExampleFile
]

{ #category : #tests }
RSFileTests >> tearDown [
	self deleteExampleFile
]

{ #category : #tests }
RSFileTests >> testCreation [
	| rsfile fileReference |
	fileReference := (Path from: './RSFiles/example.txt') asFileReference.
	rsfile := RSFile from: fileReference.
	self
		assert: rsfile name equals: 'example.txt';
		assert: rsfile sizeAsBytes equals: 15;
		assert: rsfile fileReference equals: fileReference
]

{ #category : #tests }
RSFileTests >> testPrintString [
	| rsfile |
	rsfile := RSFile
		from: (Path from: './RSFiles/example.txt') asFileReference.
	self
		assert: rsfile printString
		equals: 'Nombre: example.txt	Tamaño: 15'
]
