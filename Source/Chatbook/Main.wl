(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Header*)
BeginPackage[ "Wolfram`Chatbook`" ];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Declare Symbols*)
`$AutomaticAssistance;
`$AvailableTools;
`$ChatAbort;
`$ChatbookContexts;
`$ChatbookNames;
`$ChatbookProtectedNames;
`$ChatEvaluationCell;
`$ChatHandlerData;
`$ChatNotebookEvaluation;
`$ChatPost;
`$ChatPre;
`$ChatTimingData;
`$CurrentChatSettings;
`$DefaultChatHandlerFunctions;
`$DefaultChatProcessingFunctions;
`$DefaultModel;
`$DefaultToolOptions;
`$DefaultTools;
`$IncludedCellWidget;
`$InlineChat;
`$InstalledTools;
`$SandboxKernel;
`$ToolFunctions;
`$WorkspaceChat;
`AbsoluteCurrentChatSettings;
`AppendURIInstructions;
`BasePrompt;
`CachedBoxes;
`CellToChatMessage;
`Chatbook;
`ChatbookAction;
`ChatCellEvaluate;
`CreateChatDrivenNotebook;
`CreateChatNotebook;
`CurrentChatSettings;
`DisplayBase64Boxes;
`EnableCodeAssistance;
`ExplodeCell;
`FormatChatOutput;
`FormatToolCall;
`FormatToolResponse;
`FormatWolframAlphaPods;
`GetChatHistory;
`GetExpressionURI;
`GetExpressionURIs;
`InlineTemplateBoxes;
`InvalidateServiceCache;
`LogChatTiming;
`MakeExpressionURI;
`RelatedDocumentation;
`RelatedWolframAlphaQueries;
`SandboxLinguisticAssistantData;
`SetModel;
`SetToolOptions;
`ShowCodeAssistance;
`ShowContentSuggestions;
`StringToBoxes;
`WriteChatOutputCell;

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Begin Private Context*)
Begin[ "`Private`" ];

Needs[ "Wolfram`Chatbook`Common`" ];

(* Avoiding context aliasing due to bug 434990: *)
Needs[ "GeneralUtilities`" -> None ];

(* Clear subcontexts from `$Packages` to force `Needs` to run again: *)
WithCleanup[
    Unprotect @ $Packages,
    $Packages = Select[ $Packages, Not @* StringStartsQ[ "Wolfram`Chatbook`"~~__~~"`" ] ],
    Protect @ $Packages
];

(* ::**************************************************************************************************************:: *)
(* ::Subsection::Closed:: *)
(*Usage Messages*)
GeneralUtilities`SetUsage[ CreateChatNotebook, "\
CreateChatNotebook[] creates an empty chat notebook and opens it in the front end.\
" ];

GeneralUtilities`SetUsage[ Chatbook, "\
Chatbook is a symbol for miscellaneous chat notebook messages.\
" ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Load Files*)
$ChatbookContexts = {
    "Wolfram`Chatbook`",
    "Wolfram`Chatbook`Actions`",
    "Wolfram`Chatbook`ChatGroups`",
    "Wolfram`Chatbook`ChatHistory`",
    "Wolfram`Chatbook`ChatMessages`",
    "Wolfram`Chatbook`ChatModes`",
    "Wolfram`Chatbook`ChatState`",
    "Wolfram`Chatbook`CloudToolbar`",
    "Wolfram`Chatbook`Common`",
    "Wolfram`Chatbook`CreateChatNotebook`",
    "Wolfram`Chatbook`Dialogs`",
    "Wolfram`Chatbook`Dynamics`",
    "Wolfram`Chatbook`Errors`",
    "Wolfram`Chatbook`ErrorUtils`",
    "Wolfram`Chatbook`Explode`",
    "Wolfram`Chatbook`Feedback`",
    "Wolfram`Chatbook`Formatting`",
    "Wolfram`Chatbook`FrontEnd`",
    "Wolfram`Chatbook`Graphics`",
    "Wolfram`Chatbook`Handlers`",
    "Wolfram`Chatbook`InlineReferences`",
    "Wolfram`Chatbook`LLMUtilities`",
    "Wolfram`Chatbook`Menus`",
    "Wolfram`Chatbook`Models`",
    "Wolfram`Chatbook`PersonaManager`",
    "Wolfram`Chatbook`Personas`",
    "Wolfram`Chatbook`PreferencesContent`",
    "Wolfram`Chatbook`PreferencesUtils`",
    "Wolfram`Chatbook`PromptGenerators`",
    "Wolfram`Chatbook`Prompting`",
    "Wolfram`Chatbook`ResourceInstaller`",
    "Wolfram`Chatbook`Sandbox`",
    "Wolfram`Chatbook`SendChat`",
    "Wolfram`Chatbook`Serialization`",
    "Wolfram`Chatbook`Services`",
    "Wolfram`Chatbook`Settings`",
    "Wolfram`Chatbook`ToolManager`",
    "Wolfram`Chatbook`Tools`",
    "Wolfram`Chatbook`UI`",
    "Wolfram`Chatbook`Utils`"
};

Scan[ Needs[ # -> None ] &, $ChatbookContexts ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Names*)
$ChatbookNames := $ChatbookNames =
    Block[ { $Context, $ContextPath },
        Union[ Names[ "Wolfram`Chatbook`*" ], Names[ "Wolfram`Chatbook`*`*" ] ]
    ];

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Protected Symbols*)
$ChatbookProtectedNames = "Wolfram`Chatbook`" <> # & /@ {
    "$AutomaticAssistance",
    "$ChatbookContexts",
    "$ChatNotebookEvaluation",
    "$ChatTimingData",
    "$CurrentChatSettings",
    "$DefaultChatHandlerFunctions",
    "$DefaultChatProcessingFunctions",
    "$DefaultModel",
    "$DefaultToolOptions",
    "$DefaultTools",
    "$InlineChat",
    "$InstalledTools",
    "$ToolFunctions",
    "$WorkspaceChat",
    "AbsoluteCurrentChatSettings",
    "AppendURIInstructions",
    "BasePrompt",
    "CachedBoxes",
    "CellToChatMessage",
    "Chatbook",
    "ChatbookAction",
    "ChatCellEvaluate",
    "CreateChatDrivenNotebook",
    "CreateChatNotebook",
    "CurrentChatSettings",
    "DisplayBase64Boxes",
    "EnableCodeAssistance",
    "ExplodeCell",
    "FormatChatOutput",
    "FormatToolCall",
    "FormatToolResponse",
    "FormatWolframAlphaPods",
    "GetChatHistory",
    "GetExpressionURI",
    "GetExpressionURIs",
    "InlineTemplateBoxes",
    "LogChatTiming",
    "MakeExpressionURI",
    "RelatedDocumentation",
    "RelatedWolframAlphaQueries",
    "SandboxLinguisticAssistantData",
    "SetModel",
    "SetToolOptions",
    "ShowCodeAssistance",
    "ShowContentSuggestions",
    "StringToBoxes",
    "WriteChatOutputCell"
};

Protect @@ $ChatbookProtectedNames;

(* ::**************************************************************************************************************:: *)
(* ::Section::Closed:: *)
(*Package Footer*)
addToMXInitialization[
    $ChatbookContexts;
    $ChatbookNames;
];

mxInitialize[ ];

End[ ];
EndPackage[ ];
