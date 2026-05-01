//%attributes = {}
var $AIClient : cs:C1710.AIKit.OpenAI
$AIClient:=cs:C1710.AIKit.OpenAI.new()

$AIClient.baseURL:="http://127.0.0.1:8080/v1"  // llama-server

$query:=\
"task: クエリを与えるので、与えられたWeb検索クエリに答える関連文章を検索してください。\n"\
+\
"query: 4D Serverが使用するTCPポート番号を教えて?"

var $batch : cs:C1710.AIKit.OpenAIEmbeddingsResult
$batch:=$AIClient.embeddings.create($query)

If ($batch.success)
	$vector:=$batch.embedding.embedding
	var $comparison:={vector: $vector; metric: mk cosine:K95:1; threshold: 0.7}
	var $results:=ds:C1482.Documents.query("Embeddings > :1"; $comparison)
	If ($results.length#0)
		ALERT:C41($results.first().Text)
	End if 
End if 