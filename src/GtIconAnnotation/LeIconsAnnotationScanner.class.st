Class {
	#name : #LeIconsAnnotationScanner,
	#superclass : #SmaCCScanner,
	#category : #GtIconAnnotation
}

{ #category : #'generated-initialization' }
LeIconsAnnotationScanner class >> initializeKeywordMap [
	keywordMap := Dictionary new.
	#(#(6 'height' 2) #(6 'selector' 3))
		do: [ :each | 
			(keywordMap at: each first ifAbsentPut: [ Dictionary new ])
				at: (each at: 2)
				put: each last ].
	^ keywordMap
]

{ #category : #generated }
LeIconsAnnotationScanner >> emptySymbolTokenId [
	^ 11
]

{ #category : #generated }
LeIconsAnnotationScanner >> errorTokenId [
	^ 12
]

{ #category : #generated }
LeIconsAnnotationScanner >> scanForToken [
	self step.
	currentCharacter == $= ifTrue: [ ^ self recordAndReportMatch: #(1) ].
	currentCharacter == $| ifTrue: [ ^ self recordAndReportMatch: #(4) ].
	currentCharacter isDigit
		ifTrue: [ [ self recordMatch: #(5).
			self step.
			currentCharacter isDigit ] whileTrue.
			^ self reportLastMatch ].
	(currentCharacter isLetter or: [ currentCharacter == $_ ])
		ifTrue: [ [ self recordMatch: #(6).
			self step.
			currentCharacter isAlphaNumeric or: [ currentCharacter == $_ ] ] whileTrue ].
	^ self reportLastMatch
]
