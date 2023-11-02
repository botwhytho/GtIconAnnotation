Class {
	#name : #LeIconsStylerVisitor,
	#superclass : #LeAnnotationStylerVisitor,
	#traits : 'TLeIconParseNodeVisitor + TSmaCCComponentVisitor',
	#classTraits : 'TLeIconParseNodeVisitor classTrait + TSmaCCComponentVisitor classTrait',
	#category : #GtIconAnnotation
}

{ #category : #initialization }
LeIconsStylerVisitor class >> initialize [
	super initialize.
	LeSnippetStylerVisitor addStyler: self.
	LeContentCompletionVisitor additionalCompletionVisitors add: self
]

{ #category : #initialization }
LeIconsStylerVisitor class >> obsolete [
	LeContentCompletionVisitor additionalCompletionVisitors
		remove: self
		ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
LeIconsStylerVisitor >> styleAnnotation: anIconAnnotation [
	| aLinkColor |
	aLinkColor := anIconAnnotation source asFileReference exists
		ifTrue: [ BrGlamorousColors textMarkupColor ]
		ifFalse: [ BrGlamorousColors linkWithErrorColor ].
	(self text from: anIconAnnotation parent startPosition to: anIconAnnotation parent stopPosition) foreground: aLinkColor
]

{ #category : #visiting }
LeIconsStylerVisitor >> styleAutoHidingAnnotation: anIconAnnotation [
	| first last range |
	first := anIconAnnotation parent startPosition max: 1.
	last := anIconAnnotation parent stopPosition min: self composite text size.
	range := first to: last.
	composite
		styleAutoHiding: range
		and: range
		whenOutside: anIconAnnotation parent sourceInterval
]

{ #category : #generated }
LeIconsStylerVisitor >> styleButton: anIconAnnotation [
	| attribute errorAtribute height |
	errorAtribute := GtButtonAttribute new
			beAppend;
			stencil: [ BrButton new
					aptitude: BrGlamorousButtonWithIconAptitude;
					icon: (BrGlamorousVectorIcons debug asElement background: LepiterConstants errorColor) ].
	height := (([ (anIconAnnotation // 'HeightArgument') anyOne ]
			on: CollectionIsEmpty
			do: [ nil ])
			ifNotNil: [ :aHeight | aHeight value source asInteger ]
			ifNil: [ 16 ]) beBetween: 16 and: 64.
	([ (anIconAnnotation // 'SelectorArgument') anyOne ]
		on: CollectionIsEmpty
		do: [ nil ])
		ifNotNil: [ :aSelector | 
			(BrGlamorousVectorIcons respondsTo: aSelector value source asSymbol)
				ifTrue: [ attribute := GtButtonAttribute new
							beAppend;
							stencil: [ (BrGlamorousVectorIcons perform: aSelector value source asSymbol) asElement
									asScalableElement size: height @ height ] ]
				ifFalse: [ attribute := errorAtribute ] ]
		ifNil: [ attribute := errorAtribute ].
	self text
		attribute: attribute
		from: anIconAnnotation parent startPosition
		to: anIconAnnotation parent stopPosition
]

{ #category : #generated }
LeIconsStylerVisitor >> styleExpandingObject: anExternalFileReferenceAnnotation [
	| attribute cacheKey fileReference |
	cacheKey := anExternalFileReferenceAnnotation source.
	fileReference := cacheKey asFileReference
			ifFile: [ :aFile | cacheKey asFileReference parent ]
			ifDirectory: [ :aDirectory | cacheKey asFileReference ]
			ifAbsent: [ '.' asFileReference ].
	self flag: #BUG "expanded element only happening when file does NOT exist.".
	attribute := GtCachedTextExpandButtonAttribute new
			isExpanded: true"(self expanded at: cacheKey ifAbsentPut: [ true ])";
			attributesCreatingBlock: [ GtResizablePreviewAttribute new
					withCache: self elements key: cacheKey;
					result: fileReference;
					showSelector: #gtTreeFor:;
					height: 150	"anExternalFileReferenceAnnotation height" ]";
			onCachingDo: [ :aBoolean :theAttribute | self expanded at: cacheKey put: aBoolean ]".
	self text
		attribute: attribute
		from: anExternalFileReferenceAnnotation parent startPosition
		to: anExternalFileReferenceAnnotation parent stopPosition
]

{ #category : #generated }
LeIconsStylerVisitor >> styleHeightCursorAttribute2: anIconAnnotation [
	| first last |
	first := anIconAnnotation bar startPosition.
	last := anIconAnnotation parent right startPosition -1.
	self text
		attribute: (BrTextCursorAttribute new
				enterAction: [ :editor | 'entered height' logToPackageBeacon ];
				leaveAction: [ :editor | 'left height' logToPackageBeacon ])
		from: first
		to: last
]

{ #category : #generated }
LeIconsStylerVisitor >> styleHeightCursorAttribute: aHeightArgument [
	| first last |
	aHeightArgument logToPackageBeacon.
"	first := anIconAnnotation bar
			ifNil: [ anIconAnnotation bar stopPosition ]
			ifNotNil: [ anIconAnnotation parent
					in: [ :aParent | 
						aParent startPosition + aParent left size + aParent name size
							+ aParent colon size ] ].
	last := anIconAnnotation parent right startPosition.
	self text
		attribute: (BrTextCursorAttribute new
				enterAction: [ :editor | 'entered height' logToPackageBeacon ];
				leaveAction: [ :editor | 'left height' logToPackageBeacon ])
		from: first
		to: last"
]

{ #category : #generated }
LeIconsStylerVisitor >> styleSelectorCursorAttribute2: anIconAnnotation [
	| first last |
	first := anIconAnnotation parent in: [ :aParent | aParent colon startPosition ].
	last := anIconAnnotation bar
			ifNotNil: [ anIconAnnotation bar startPosition - 1 ]
			ifNil: [ anIconAnnotation parent right startPosition - 1 ].
	self text
		attribute: (BrTextCursorAttribute new
				enterAction: [ :editor | 
					'entered selector' logToPackageBeacon.
					self composite
						completionResult: (LeIconSelectorCompletionResult forSelector: (first to: last)) ];
				leaveAction: [ :editor | 'left selector' logToPackageBeacon ])
		from: first
		to: last	"
				ifTrue: [ completion := LeIconSelectorCompletionResult
					forSelector: (selectorBegin  to: selectorEnd) ]
		ifFalse: [ completion := LeIconHeightCompletionResult
					forHeight: {(heightBegin to: heightEnd).currentSelector} ]."
]

{ #category : #generated }
LeIconsStylerVisitor >> styleSelectorCursorAttribute: aSelectorArgument [
	| first last |
	"aSelectorArgument logToPackageBeacon."
	first := aSelectorArgument parent
			in: [ :aParent | 
				aParent startPosition + aParent left size + aParent name size
					+ aParent colon size - 1 ].
	last := aSelectorArgument bar
			ifNil: [ aSelectorArgument bar startPosition ]
			ifNotNil: [ aSelectorArgument parent right startPosition ].
	self text
		attribute: (BrTextCursorAttribute new
				enterAction: [ :editor | 'entered selector' logToPackageBeacon ];
				leaveAction: [ :editor | 'left selector' logToPackageBeacon ])
		from: first
		to: last
]

{ #category : #generated }
LeIconsStylerVisitor >> visitAnnotation: anIconAnnotation [
	anIconAnnotation logToPackageBeacon.
	"self styleAnnotation: anIconAnnotation."
	self styleAutoHidingAnnotation: anIconAnnotation.
	self styleSelectorCursorAttribute2: anIconAnnotation.
	self styleHeightCursorAttribute2: anIconAnnotation.
	self styleButton: anIconAnnotation.
	"self styleExpandingObject: anIconAnnotation"
]

{ #category : #generated }
LeIconsStylerVisitor >> visitHeightArgument: aHeightArgument [
	self styleHeightCursorAttribute: aHeightArgument.
	^ self visitArgument: aHeightArgument
]

{ #category : #generated }
LeIconsStylerVisitor >> visitSelectorArgument: aSelectorArgument [
	self styleSelectorCursorAttribute: aSelectorArgument.
	^ self visitArgument: aSelectorArgument
]

{ #category : #visiting }
LeIconsStylerVisitor >> visitSmaCCError: aSmaCCError [
	aSmaCCError logToBeacon.
	^ self visitSmaCCParseNode: aSmaCCError
]
