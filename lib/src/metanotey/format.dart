

import '../../flutter_quill.dart';
import '../models/rules/format.dart';

/// 增加一个格式化规则 用来支持结构化功能 主要支持style script 属性更新
class MetaNoteyFormatLinkTypeRule extends FormatRule {
  const MetaNoteyFormatLinkTypeRule();

  @override
  Delta? applyRule(Delta document, int index,
      {int? len, Object? data, Attribute? attribute}) {

    if (attribute!.key != Attribute.style.key
        && attribute.key != Attribute.script.key
        /*&& attribute.key != Attribute.link.key*/) {
      return null;
    }

    final delta = Delta()..retain(index);
    final itr = DeltaIterator(document)..skip(index);

    Operation op;
    for (var cur = 0; cur < len! && itr.hasNext; cur += op.length!) {
      op = itr.next(len - cur);
      final text = op.data is String ? (op.data as String?)! : '';
      var lineBreak = text.indexOf('\n');
      if (lineBreak < 0) {
        delta.retain(op.length!, attribute.toJson());
        continue;
      }
      var pos = 0;
      while (lineBreak >= 0) {
        delta
          ..retain(lineBreak - pos, attribute.toJson())
          ..retain(1);
        pos = lineBreak + 1;
        lineBreak = text.indexOf('\n', pos);
      }
      if (pos < op.length!) {
        delta.retain(op.length! - pos, attribute.toJson());
      }
    }

    return delta;


  }
}