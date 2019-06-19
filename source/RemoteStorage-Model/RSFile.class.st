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

{ #category : #accessing }
RSFile >> filePath [
	^ 'RSFiles/' , fileReference pathSegments last
]

{ #category : #accessing }
RSFile >> fileReference [
	^ fileReference
]

{ #category : #initialization }
RSFile >> initializeFrom: aFileReference [
	fileReference := aFileReference
]

{ #category : #accessing }
RSFile >> name [
	^ fileReference pathSegments last
]

{ #category : #printing }
RSFile >> printOn: aStream [
	aStream
		nextPutAll: 'Nombre: ';
		nextPutAll: self name;
		tab;
		nextPutAll: 'Tamaño: ';
		nextPutAll: self sizeAsBytes asString
]

{ #category : #accessing }
RSFile >> sizeAsBytes [
	^ fileReference size
]
