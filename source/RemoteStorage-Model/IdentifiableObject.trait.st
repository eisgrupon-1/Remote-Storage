Trait {
	#name : #IdentifiableObject,
	#instVars : [
		'uuid'
	],
	#category : #'RemoteStorage-Model-Core'
}

{ #category : #accessing }
IdentifiableObject >> uuid [
	uuid ifNil: [ uuid := UUID new ].
	^ uuid
]
