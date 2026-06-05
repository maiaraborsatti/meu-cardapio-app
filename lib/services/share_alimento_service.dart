import 'package:share_plus/share_plus.dart';
import '../models/alimento.dart';

class ShareAlimentoService {
  void compartilharAlimento(Alimento alimento) {
    final nome = alimento.nome;
    final categoria = alimento.categoria;
    final tipo = alimento.tipo;

    String texto = "🍽️ ALIMENTO\n\n";

    texto += "🥗 Nome: $nome\n";

    if (categoria.isNotEmpty) {
      texto += "📂 Categoria: $categoria\n";
    }

    if (tipo.isNotEmpty) {
      texto += "🏷️ Tipo: $tipo\n";
    }

    Share.share(texto);
  }
}