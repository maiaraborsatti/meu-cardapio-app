import 'package:share_plus/share_plus.dart';
import '../database/repositories/cardapio_repository.dart';

class ShareCardapioService {
  final CardapioRepository _repo = CardapioRepository();

  Future<void> compartilharCardapioPorId(int usuarioId, int cardapioId) async {
  final dados = await _repo.buscarCardapioCompletoDoUsuario(usuarioId);

  final itens = dados
      .where((item) => item['cardapio_id'] == cardapioId)
      .toList();

  if (itens.isEmpty) {
    Share.share("🍽️ Cardápio vazio.");
    return;
  }

  String texto = "🍽️ CARDÁPIO #$cardapioId\n";

  Map<String, List<Map<String, dynamic>>> porRefeicao = {};

  for (var item in itens) {
    final refeicao = item['refeicao'] ?? 'Sem refeição';
    porRefeicao.putIfAbsent(refeicao, () => []).add(item);
  }

  porRefeicao.forEach((refeicao, lista) {
    texto += "\n━━━━━━━━━━━━━━\n";
    texto += "🍽️ $refeicao\n";

    for (var item in lista) {
      texto += "• ${item['alimento_nome']} \n";
    }
  });

  Share.share(texto);
}
}