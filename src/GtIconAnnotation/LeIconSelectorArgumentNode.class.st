Class {
	#name : #LeIconSelectorArgumentNode,
	#superclass : #LeIconArgumentNode,
	#category : #GtIconAnnotation
}

{ #category : #generated }
LeIconSelectorArgumentNode >> acceptVisitor: aParseVisitor [
	^ aParseVisitor visitSelectorArgument: self
]
