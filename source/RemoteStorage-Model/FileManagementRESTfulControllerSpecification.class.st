Class {
	#name : #FileManagementRESTfulControllerSpecification,
	#superclass : #ResourceRESTfulControllerSpecification,
	#category : #'RemoteStorage-Model-API'
}

{ #category : #configuration }
FileManagementRESTfulControllerSpecification >> addJsonFileVersion1dot0dot0MappingIn: aBuilder [
	aBuilder
		addDefaultRuleToEncode: self fileMappingKey
		to: self fileVersion1dot0dot0MediaType
		using: [ :resource :context | 
			String
				streamContents: [ :stream | 
					(NeoJSONWriter on: stream)
						for: RSFile
							do: [ :mapping | mapping mapAccessors: #(#name #sizeAsBytes #rawContent) ];
						nextPut: resource ] ]
]

{ #category : #configuration }
FileManagementRESTfulControllerSpecification >> addJsonFilesVersion1dot0dot0MappingIn: aBuilder [
	aBuilder
		addDefaultRuleToEncode: self filesMappingKey
		to: self fileVersion1dot0dot0MediaType
		using: [ :resource :context | 
			String
				streamContents: [ :stream | 
					(NeoJSONWriter on: stream)
						for: RSFile
							do: [ :mapping | 
							mapping
								mapAccessors: #(#name #sizeAsBytes #uuid);
								mapAsHypermediaControls: [ :file | context hypermediaControlsFor: file ] ];
						nextPut: resource ] ]
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> endpoint [
	^ '/rsfiles'
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> fileMappingKey [
	^ 'rsfile'
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> fileTemplate [
	<ignoreForCoverage>
	^ '<1s>/%<<2s>:IsUUID>'
		expandMacrosWith: self endpoint
		with: #identifier
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> fileVersion1dot0dot0MediaType [
	^ 'application/vnd.remotestorage.file+json;version=1.0.0' asMediaType
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> filesMappingKey [
	^ 'rsfiles'
]

{ #category : #acccessing }
FileManagementRESTfulControllerSpecification >> getFilesRoute [
	<ignoreForCoverage>
	^ RouteSpecification
		handling: #GET
		at: self endpoint
		evaluating:
			[ :service :httpRequest :context | service getFilesBasedOn: httpRequest within: context ]
]
