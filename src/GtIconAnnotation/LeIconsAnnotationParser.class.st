Class {
	#name : #LeIconsAnnotationParser,
	#superclass : #SmaCCGLRParser,
	#category : #GtIconAnnotation
}

{ #category : #'generated-accessing' }
LeIconsAnnotationParser class >> cacheId [
	^'2023-11-02T02:15:08.867103-04:00'
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
<labelText>
	: [^\|\}]+
	;

Annotation 
	: Selector 'item' (""|"" 'bar' Height 'item')?  {{}}
	;
Selector
	: (""selector"" 'name' ""="" 'equals')? <unarySelector> 'value' {{SelectorArgument}}
	;
Height
	: (""height"" 'name' ""="" 'equals')? <integer> 'value' {{HeightArgument}}
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
	#(9 1 #reduceActionForSelector1: 307201 false) 
	#(8 1 #reduceActionForAnnotation1: 238593 false) 
	#(9 3 #reduceActionForSelector2: 307202 false) 
	#(10 1 #reduceActionForHeight1: 403457 false) 
	#(8 3 #reduceActionForAnnotation2: 238594 false) 
	#(10 3 #reduceActionForHeight2: 403458 false)
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
	^ #('"="' '"height"' '"selector"' '"|"' '<integer>' '<unarySelector>' 'B e g i n' 'Annotation' 'Selector' 'Height' 'E O F' 'error')
]

{ #category : #generated }
LeIconsAnnotationParser class >> symbolTypes [
	^ #(#SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #SmaCCToken #LeIconAnnotationNode #LeIconAnnotationNode #LeIconSelectorArgumentNode #LeIconHeightArgumentNode #SmaCCToken #SmaCCErrorNode)
]

{ #category : #generated }
LeIconsAnnotationParser class >> transitionTable [
^#(
#[1 0 9 0 3 0 13 0 6 0 17 0 8 0 21 0 9] 
#[0 0 25 0 1] 
#[0 0 6 0 4 0 11] 
#[0 0 0 0 11] 
#[1 0 29 0 4 0 10 0 11] 
#[0 0 33 0 6] 
#[1 0 37 0 2 0 41 0 5 0 45 0 10] 
#[0 0 14 0 4 0 11] 
#[0 0 49 0 1] 
#[0 0 18 0 11] 
#[0 0 22 0 11] 
#[0 0 53 0 5] 
#[0 0 26 0 11]
	).
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForAnnotation1: nodes [
	| result |
	result := LeIconAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForAnnotation2: nodes [
	| result |
	result := LeIconAnnotationNode new.
	result addNode: (nodes at: 1) to: result items.
	result bar: (nodes at: 2).
	result addNode: (nodes at: 3) to: result items.
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForHeight1: nodes [
	| result |
	result := LeIconHeightArgumentNode new.
	result value: (nodes at: 1).
	^ result
]

{ #category : #'generated-reduction actions' }
LeIconsAnnotationParser >> reduceActionForHeight2: nodes [
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
