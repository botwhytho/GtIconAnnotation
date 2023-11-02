Class {
	#name : #LeIconSelectorCompletionResult,
	#superclass : #GtCompletionResult,
	#instVars : [
		'interval'
	],
	#category : #GtIconAnnotation
}

{ #category : #'instance creation' }
LeIconSelectorCompletionResult class >> forSelector: anInterval [
	^ self new
		interval: anInterval;
		yourself
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> actionForEntity: aSelector [
	| insertionAction text |
	text := aSelector asString.
	insertionAction := GtInsertTextCompletionAction
		labeled: text
		completion: text
		position: self interval first - 1
		from: self interval first - 1.
	self interval last > self interval first
		ifTrue:
			[ ^ (GtCompositeCompletionAction labeled: text)
				addAction:
						(GtDeleteTextCompletionAction
								labeled: text
								from: self interval first
								to: self interval last - 1);
				addAction: insertionAction ].
	^ insertionAction
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> hasCompletionActions [
	"This was needed for completion to appear. Same implementation as GtCalendarCompletionResult"
	^ true
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> iconSelectorElement: someArgs [
	| aController aDropdown insets numberOfColumns previewHeight width |
	aController := someArgs first.
	aDropdown := someArgs second.
	insets := 4.
	previewHeight := 128.
	numberOfColumns := 6.
	width := (previewHeight * numberOfColumns) + ((numberOfColumns) * insets * 2).
	^ BlElement new
		layout: BlFlowLayout new;
		width: width;
		constraintsDo: [ :c | c vertical fitContent ];
		addChildren: (BrGlamorousVectorIcons allIcons
				collect: [ :each | 
					BrVerticalPane new
						aptitude: BrShadowAptitude new;
						margin: (BlInsets all: insets);
						background: Color white;
						constraintsDo: [ :c | 
							c vertical fitContent.
							c horizontal fitContent ];
						addChildren: {BrLabel new
									aptitude: BrGlamorousLabelAptitude;
									text: each key asString.
								each value asElement asScalableElement
									size: previewHeight @ previewHeight};
						when: BlClickEvent
							do: [ | task |
								task := [ | completionAction |
									completionAction := self actionForEntity: each key.
									aController completeWithAction: completionAction ] asBlTask.
								(aController instVarNamed: #textElement) enqueueTask: task.
								aDropdown fireEvent: BrDropdownHideWish new ] ]);
		asScrollableElement	"544"
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> interval [

	^ interval
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> interval: anObject [

	interval := anObject
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> newIconSelectorFor: aController [
	| aButton aWithDropdownLook |
	aWithDropdownLook := BrGlamorousWithDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ self
					iconSelectorElement: {aController.
							aButton} ].
	aButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude + aWithDropdownLook;
			icon: BrGlamorousIcons menu.
	^ aButton
]

{ #category : #accessing }
LeIconSelectorCompletionResult >> showOn: aController [
	| element showTask |
	element := self newIconSelectorFor: aController.
	aController popupElement: element.
	
	showTask := BlTaskAction new 
		action: [ element fireEvent: BrDropdownShowWish new ];
		yourself.
	element enqueueTask: showTask
]
