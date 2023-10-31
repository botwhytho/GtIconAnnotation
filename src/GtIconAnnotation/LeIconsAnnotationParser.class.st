Class {
	#name : #LeIconsAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #GtIconAnnotation
}

{ #category : #'generated-accessing' }
LeIconsAnnotationParser class >> cacheId [
	^'2023-10-31T00:06:34.839854-04:00'
]

{ #category : #generated }
LeIconsAnnotationParser class >> definitionComment [
"%glr;


%root Parse;
%prefix LeIcon;
%suffix Node;
%hierarchy Argument (
	SelectorArgument
	HeightArgument
);

<integer>
	: \d+
	;
<unarySelector>
	: (<isLetter> | _ ) ( <isLetter> | _ | <isDigit> ) *
	;

Annotation 
	: Item 'item' (""|"" 'bar' Item 'item')* ""|"" 'bar'? {{}}
	;
Item
	: Selector
	| Height
	;
Selector
	: (""selector"" 'name' ""="" 'equals')? <unarySelector> 'value' {{SelectorArgument}}
	| <unarySelector> 'value' {{SelectorArgument}}
	;
Height
	: ""height"" 'name' ""="" 'equals' <integer> 'value' {{HeightArgument}}
	;"
]

{ #category : #initialization }
LeIconsAnnotationParser class >> initialize [
	super initialize.
	LeParser annotationParsers
		at: 'gtIcon'
		put: [ :parser | parser spawnParser: self startingAt: self startingStateForAnnotation ]
]

{ #category : #initialization }
LeIconsAnnotationParser class >> obsolete [
	LeParser annotationParsers removeKey: 'gtIcon' ifAbsent: [  ].
	^ super obsolete
]

{ #category : #generated }
LeIconsAnnotationParser class >> reduceTable [
^#(
	#(12 1 #reduceActionForSelector1: 314369 false) 
	#(10 0 #reduceActionFor______bar__Item__item___1: 238593 false) 
	#(11 1 #liftFirstValue: 283649 false) 
	#(11 1 #liftFirstValue: 283650 false) 
	#(8 2 #reduceActionForAnnotation1: 210945 false) 
	#(13 3 #reduceActionForHeight1: 459777 false) 
	#(12 3 #reduceActionForSelector2: 314370 false) 
	#(8 3 #reduceActionForAnnotation2: 210946 false) 
	#(10 2 #reduceActionFor______bar__Item__item___2: 238594 false) 
	#(9 2 #reduceActionFor______bar__Item__item__1: 238593 false)
	).
]

{ #category : #generated }
LeIconsAnnotationParser class >> scannerClass [
	^LeIconsAnnotationScanner
]

{ #category : #generated }
LeIconsAnnotationParser class >> startingStateForAnnotation [
	^ 1
]

{ #category : #generated }
LeIconsAnnotationParser class >> symbolNames [
	^ #('"="' '"height"' '"selector"' '"|"' '<integer>' '<unarySelector>' 'B e g i n' 'Annotation' '("|" ''bar'' Item ''item'')' '("|" ''bar'' Item ''item'')*' 'Item' 'Selector' 'Height' 'E O F' 'error')
]

{ #category : #generated }
LeIconsAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeIconAnnotationNode #LeIconAnnotationNode #OrderedCollection #OrderedCollection #LeIconArgumentNode #LeIconSelectorArgumentNode #LeIconHeightArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeIconsAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 2 0 13 0 3 0 17 0 6 0 21 0 8 0 25 0 11 0 25 0 12 0 25 0 13] 
#[0 0 37 0 1] 
#[0 0 41 0 1] 
#[0 0 6 0 4 0 14] 
#[0 0 0 0 14] 
#[1 0 10 0 4 0 45 0 10 0 10 0 14] 
#[0 0 14 0 4 0 14] 
#[0 0 18 0 4 0 14] 
#[0 0 49 0 5] 
#[0 0 53 0 6] 
#[1 0 57 0 4 0 61 0 9 0 22 0 14] 
#[0 0 26 0 4 0 14] 
#[0 0 30 0 4 0 14] 
#[1 0 9 0 2 0 13 0 3 0 17 0 6 0 65 0 11 0 65 0 12 0 65 0 13 0 34 0 14] 
#[0 0 38 0 4 0 14] 
#[0 0 42 0 4 0 14]
	).
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := LeIconAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := LeIconAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result addTokens: ((nodes at: 2) at: 1) to: result bars.
	result addNodes: ((nodes at: 2) at: 2) to: result items.
	result addToken: (nodes at: 3) to: result bars.
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeIconHeightArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForSelector1: nodes [
	| result |
	result := LeIconSelectorArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForSelector2: nodes [
	| result |
	result := LeIconSelectorArgumentNode new.
	result name: (nodes at: 1).
	result equals: (nodes at: 2).
	result value: (nodes at: 3).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionFor______bar__Item__item__1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (nodes at: 1).
	result at: 2 put: (nodes at: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionFor______bar__Item__item___1: nodes [
	| result |
	result := Array new: 2.
	result at: 1 put: (OrderedCollection new: 2).
	result at: 2 put: (OrderedCollection new: 2).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionFor______bar__Item__item___2: nodes [
	| result |
	result := nodes at: 1.
	self add: ((nodes at: 2) at: 1) to: (result at: 1).
	self add: ((nodes at: 2) at: 2) to: (result at: 2).
	^ result
]
