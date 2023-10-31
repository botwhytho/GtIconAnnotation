Trait {
	#name : #TLeIconParseNodeVisitor,
	#traits : 'TSmaCCParseNodeVisitor',
	#classTraits : 'TSmaCCParseNodeVisitor classTrait',
	#category : #GtIconAnnotation
}

{ #category : #generated }
TLeIconParseNodeVisitor >> visitAnnotation: anAnnotation [
	^ self visitParse: anAnnotation
]

{ #category : #generated }
TLeIconParseNodeVisitor >> visitArgument: anArgument [
	^ self visitParse: anArgument
]

{ #category : #generated }
TLeIconParseNodeVisitor >> visitHeightArgument: aHeightArgument [
	^ self visitArgument: aHeightArgument
]

{ #category : #generated }
TLeIconParseNodeVisitor >> visitParse: aParse [
	^ self visitSmaCCParseNode: aParse
]

{ #category : #generated }
TLeIconParseNodeVisitor >> visitSelectorArgument: aSelectorArgument [
	^ self visitArgument: aSelectorArgument
]
