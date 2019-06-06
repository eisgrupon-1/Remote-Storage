Trait {
	#name : #IdentifiableObject,
	#instVars : [
		'uuid'
	],
	#category : #'RemoteStorage-Model-API'
}

{ #category : #accessing }
IdentifiableObject >> uuid [
	uuid ifNil: [ uuid := UUID new ].
	^ uuid
]
