Class {
	#name : #LeIconParseNode,
	#superclass : #SmaCCParseNode,
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconParseNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitParse: self
]
