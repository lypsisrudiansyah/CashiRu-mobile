import 'package:cashiru/core/constants/variables.dart';
import 'package:esc_pos_utils_plus/esc_pos_utils_plus.dart';
import 'package:cashiru/core/extensions/int_extension.dart';
import 'package:cashiru/presentation/home/models/order_item.dart';
import 'package:intl/intl.dart';

class PrinterService {
  PrinterService._init();
  static final PrinterService instance = PrinterService._init();

  Future<List<int>> printOrder(
    String paymentMethod,
    List<OrderItem> orders,
    int totalQuantity,
    int total,
  ) async {
    List<int> bytes = [];
    final profile = await CapabilityProfile.load();
    final generator = Generator(PaperSize.mm58, profile);
    bytes += generator.reset();
    bytes += generator.text(
      'Receipt',
      styles: const PosStyles(
        bold: true,
        align: PosAlign.center,
        height: PosTextSize.size1,
        width: PosTextSize.size1,
      ),
    );
    bytes += generator.text(
      Variables.nameApp,
      styles: const PosStyles(bold: true, align: PosAlign.center),
    );
    bytes += generator.text(
      'Date : ${DateFormat('dd-MM-yyyy HH:mm').format(DateTime.now())}',
      styles: const PosStyles(bold: false, align: PosAlign.center),
    );
    bytes += generator.feed(1);
    bytes += generator.text(
      'Orders:',
      styles: const PosStyles(bold: false, align: PosAlign.center),
    );
    //for from data
    for (final product in orders) {
      bytes += generator.text(
        product.product.name!,
        styles: const PosStyles(align: PosAlign.left),
      );

      bytes += generator.row([
        PosColumn(
          text: '${product.product.price} x ${product.quantity}',
          width: 8,
          styles: const PosStyles(align: PosAlign.left),
        ),
        PosColumn(
          text:
              (double.parse(product.product.price!).toInt() * product.quantity)
                  .currencyFormatRpV2,
          width: 4,
          styles: const PosStyles(align: PosAlign.right),
        ),
      ]);
    }
    bytes += generator.feed(1);

    bytes += generator.row([
      PosColumn(
        text: 'Total',
        width: 6,
        styles: const PosStyles(align: PosAlign.left),
      ),
      PosColumn(
        text: total.currencyFormatRp,
        width: 6,
        styles: const PosStyles(align: PosAlign.right),
      ),
    ]);
    bytes += generator.feed(1);
    bytes += generator.text(
      'Thank you for your order!',
      styles: const PosStyles(bold: false, align: PosAlign.center),
    );
    bytes += generator.feed(3);
    return bytes;
  }
}
