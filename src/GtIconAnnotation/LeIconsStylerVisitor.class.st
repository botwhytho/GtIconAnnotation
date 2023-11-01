Class {
	#name : #LeIconsStylerVisitor,
	#superclass : #LeAnnotationStylerVisitor,
	#traits : 'TLeIconParseNodeVisitor',
	#classTraits : 'TLeIconParseNodeVisitor classTrait',
	#category : #GtIconAnnotation
}

{ #category : #initialization }
LeIconsStylerVisitor class >> initialize [
	super initialize.
	LeSnippetStylerVisitor addStyler: self
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
LeIconsStylerVisitor >> styleHeightCursorAttribute: anIconAnnotation [
	| first last |
	first := anIconAnnotation bar
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
		to: last
]

{ #category : #generated }
LeIconsStylerVisitor >> styleSelectorCursorAttribute: anIconAnnotation [
	| first last |
	first := anIconAnnotation parent
			in: [ :aParent | 
				aParent startPosition + aParent left size + aParent name size
					+ aParent colon size - 1 ].
	last := anIconAnnotation bar
			ifNil: [ anIconAnnotation bar startPosition ]
			ifNotNil: [ anIconAnnotation parent right startPosition ].
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
	self styleSelectorCursorAttribute: anIconAnnotation.
	self styleHeightCursorAttribute: anIconAnnotation.
	self styleButton: anIconAnnotation.
	"self styleExpandingObject: anIconAnnotation"
]
