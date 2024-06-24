import 'package:flutter/material.dart';
import 'package:investment_app/src/features/explore_feed/data/module_api_service.dart';
import 'package:investment_app/src/features/explore_feed/model/module_model.dart';
import 'package:investment_app/src/features/explore_feed/presenter/widget/module_tile.dart';

class ModuleTab extends StatelessWidget {
  const ModuleTab({super.key});

  @override
  Widget build(BuildContext context) {
    final moduleApiService = ModuleApiService();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: FutureBuilder<List<ModuleModel>>(
        future: moduleApiService.getModules(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No modules available.'));
          } else {
            final moduleTileData = snapshot.data!;
            return buildBody(moduleTileData);
          }
        },
      ),
    );
  }

  ListView buildBody(List<ModuleModel> blogTileData) {
    return ListView.builder(
            shrinkWrap: true,
            itemCount: blogTileData.length,
            itemBuilder: (context, index) {
              return ModuleTile(module: blogTileData[index]);
            },
          );
  }
}
