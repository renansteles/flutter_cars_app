
//Classe ApiResponse é tipada, recebe objeto generico quando instanciada.
class ApiResponse<T> {
	bool ok;
	String mensagem;
	T result; //objeto genérico

	//NameConstructor, ou seja, construtor com nome. No exemplo o nome é OK
	ApiResponse.ok(this.result){
		ok = true;
	}

	ApiResponse.erro(this.mensagem) {
		ok = false;
	}
}