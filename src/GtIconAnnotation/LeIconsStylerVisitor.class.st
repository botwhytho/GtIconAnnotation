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
	| attribute |
	attribute := GtButtonAttribute new
			beAppend;
			stencil: BrGlamorousVectorIcons rustLogo.
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
LeIconsStylerVisitor >> visitAnnotation: anIconAnnotation [
	anIconAnnotation logToPackageBeacon.
	"self styleAnnotation: anIconAnnotation."
	self styleAutoHidingAnnotation: anIconAnnotation.
	self styleButton: anIconAnnotation.
	"self styleExpandingObject: anIconAnnotation"
]
