Class {
	#name : #RSFile,
	#superclass : #Object,
	#traits : 'IdentifiableObject',
	#classTraits : 'IdentifiableObject classTrait',
	#instVars : [
		'fileReference'
	],
	#category : #'RemoteStorage-Model-Core'
}

{ #category : #'instance creation' }
RSFile class >> from: aFileReference [
	^ self new initializeFrom: aFileReference
]

{ #category : #initialization }
RSFile >> initializeFrom: aFileReference [
	fileReference := aFileReference
]

{ #category : #acccessing }
RSFile >> name [
	^ fileReference pathSegments last
]

{ #category : #accessing }
RSFile >> printOn: aStream [
	aStream
		nextPutAll: 'Nombre: ' , self name;
		tab;
		nextPutAll: 'Tamaño: ' , self sizeAsBytes asString
]

{ #category : #acccessing }
RSFile >> size [
	"Size in MB"

	^ fileReference size / 1048576
]

{ #category : #accessing }
RSFile >> sizeAsBytes [
	^ fileReference size
]
