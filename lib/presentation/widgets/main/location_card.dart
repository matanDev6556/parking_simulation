import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pumba_ex/presentation/bloc/location/location_cubit.dart';
import 'package:pumba_ex/presentation/bloc/location/location_state.dart';
import 'package:pumba_ex/presentation/widgets/general/custom_bttn.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final isLoading = state.status == LocationStatus.loading;
        final hasLocation =
            state.status == LocationStatus.granted && state.position != null;
        final isDinined = state.status == LocationStatus.denied;

        return Card(
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: Colors.white.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Your location',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0A2472),
                  ),
                ),
                const SizedBox(height: 10),
                if (isLoading)
                  const CircularProgressIndicator()
                else
                  Text(
                    hasLocation
                        ? '${state.position!.latitude}, ${state.position!.longitude}'
                        : 'Location not available',
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xFF0A2472)),
                    textAlign: TextAlign.center,
                  ),
                const SizedBox(height: 15),
                CustomButton(
                  onPressed: () =>
                      context.read<LocationCubit>().checkAndRequestLocation(),
                  iconData:
                      hasLocation ? Icons.location_on : Icons.location_off,
                  padding: const EdgeInsets.all(10),
                  text: isDinined ? 'Allow Location' : 'Refresh Location',
                  backgroundColor: const Color(0xFF3A86FF),
                  textColor: Colors.white,
                  width: double.infinity,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
