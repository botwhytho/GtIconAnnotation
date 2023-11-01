Class {
	#name : #LeIconCompletionResult,
	#superclass : #GtCompletionResult,
	#instVars : [
		'interval'
	],
	#category : #GtIconAnnotation
}

{ #category : #'instance creation' }
LeIconCompletionResult class >> forHeight: anInterval [
	^ self new
		interval: anInterval;
		yourself
]

{ #category : #accessing }
LeIconCompletionResult >> actionForEntity: anInteger [
	| insertionAction text |
	text := 'height=', anInteger asString.
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
	
	"Adapted from GtCalendarCompletionResult>>#actionForDate:"
]

{ #category : #accessing }
LeIconCompletionResult >> hasCompletionActions [
	"This was needed for completion to appear. Same implementation as GtCalendarCompletionResult"
	^ true
]

{ #category : #accessing }
LeIconCompletionResult >> heightSLiderElement: someArgs [
	| aController aDropdown horizontalPane rust container label check verticalPane line slider |
	aController := someArgs first.
	aDropdown := someArgs second.
	line := BlElement new
			size: 250 @ 1;
			background: Color veryLightGray.
	slider := GtInspectorRoundButtonStencil small asElement
			addEventHandler: BlPullHandler new disallowOutOfBounds beHorizontal;
			when: BlPullEvent
				do: [ | height |
					height := 16 + (48 * (slider position x / line width)) asFloat roundUpTo: 1.
					rust size: height @ height.
					label text: height ].
	container := BlElement new
			addChild: (line relocate: 8 @ 12) as: #line;
			addChild: (slider relocate: 6 @ 4) as: #slider;
			size: 256 @ 16 + 8;
			padding: 16.
	rust := BrGlamorousVectorIcons largeRustLogo asElement asScalableElement
			size: 16 @ 16.
	check := BrButton new
			margin: (BlInsets all: 8);
			aptitude: BrGlamorousButtonWithIconAptitude;
			icon: BrGlamorousVectorIcons accept;
			action: [ | task |
			task := [ 
					| completionAction |
					completionAction := self actionForEntity: label text.
					aController completeWithAction: completionAction ] asBlTask.
			(aController instVarNamed: #textElement) enqueueTask: task.
			aDropdown fireEvent: BrDropdownHideWish new.
			 ].
	label := BrLabel new
			aptitude: BrGlamorousLabelAptitude;
			text: 16.
	verticalPane := BrVerticalPane new
			margin: (BlInsets all: 8);
			fitContent;
			alignCenter;
			addChildren: {container.
					rust}.
	horizontalPane := BrHorizontalPane new
			fitContent;
			aptitude: BrShadowAptitude new;
			margin: (BlInsets all: 8);
			background: Color white;
			addChildren: {verticalPane.
					BrVerticalPane new
						margin: (BlInsets all: 8);
						fitContent;
						alignCenter;
						addChildren: {check.
								label}}.
	^ horizontalPane
]

{ #category : #accessing }
LeIconCompletionResult >> interval [

	^ interval
]

{ #category : #accessing }
LeIconCompletionResult >> interval: anObject [

	interval := anObject
]

{ #category : #accessing }
LeIconCompletionResult >> newHeightSliderFor: aController [
	| aButton aWithDropdownLook |
	aWithDropdownLook := BrGlamorousWithDropdownAptitude
			handle: [ BrButton new
					aptitude: BrGlamorousButtonRectangularAptitude + BrGlamorousButtonIconAptitude;
					icon: BrGlamorousIcons menu ]
			content: [ self
					heightSLiderElement: {aController.
							aButton} ].
	aButton := BrButton new
			aptitude: BrGlamorousButtonWithIconAptitude + aWithDropdownLook;
			icon: BrGlamorousIcons menu.
	^ aButton
]

{ #category : #accessing }
LeIconCompletionResult >> showOn: aController [
	| element showTask |
	element := self newHeightSliderFor: aController.
	aController popupElement: element.
	
	showTask := BlTaskAction new 
		action: [ element fireEvent: BrDropdownShowWish new ];
		yourself.
	element enqueueTask: showTask
]
