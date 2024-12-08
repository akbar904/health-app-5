import 'package:flutter/material.dart';
import 'package:gyde_app/models/booking/booking_model.dart';
import 'package:gyde_app/ui/common/app_colors.dart';
import 'package:gyde_app/ui/widgets/booking_details_card.dart';
import 'package:gyde_app/ui/views/booking_confirmation/booking_confirmation_viewmodel.dart';
import 'package:stacked/stacked.dart';

class BookingConfirmationView
    extends StackedView<BookingConfirmationViewModel> {
  final Booking booking;

  const BookingConfirmationView({
    required this.booking,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    BookingConfirmationViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Confirmation'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 80,
            ),
            const SizedBox(height: 16),
            const Text(
              'Booking Confirmed!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Booking Reference: ${booking.id}',
              style: const TextStyle(
                fontSize: 16,
                color: kcMediumGrey,
              ),
            ),
            const SizedBox(height: 24),
            BookingDetailsCard(booking: booking),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: viewModel.navigateToHome,
                child: const Text(
                  'Return to Home',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  BookingConfirmationViewModel viewModelBuilder(BuildContext context) =>
      BookingConfirmationViewModel();

  @override
  void onViewModelReady(BookingConfirmationViewModel viewModel) =>
      viewModel.initialize(booking);
}
