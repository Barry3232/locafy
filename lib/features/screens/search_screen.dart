import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:locafy/features/screens/details.dart';
import 'package:locafy/features/services/serch_service.dart';
import 'package:locafy/models/business_model.dart';
import 'package:locafy/widgets/home_section/category_wiget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  final SearchService _searchService = SearchService();
  Position? userPosition;

  final List<String> _recentSearches = ["Aroma Café", "Genesis Mall"];

  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _removeSearch(String search) {
    setState(() {
      _recentSearches.remove(search);
    });
  }

  void _clearAllSearches() {
    setState(() {
      _recentSearches.clear();
    });
  }

  void _search(String value) {
    setState(() {
      _searchQuery = value.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isSearching = _searchQuery.isNotEmpty;

    return Scaffold(
      backgroundColor: const Color(0xffF7F8FC),

      appBar: AppBar(
        backgroundColor: const Color(0xffF7F8FC),
        elevation: 0,
        automaticallyImplyLeading: false,
        title: const Text(
          "Search",
          style: TextStyle(
            color: Color(0xff171B26),
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const SizedBox(height: 10),

            TextField(
              controller: _searchController,

              onChanged: _search,

              onSubmitted: (value) {
                final search = value.trim();

                if (search.isEmpty) return;

                setState(() {
                  _recentSearches.remove(search);
                  _recentSearches.insert(0, search);
                  _searchQuery = search;
                });
              },

              decoration: InputDecoration(
                hintText: "Search businesses, places...",

                hintStyle: const TextStyle(
                  color: Color(0xff737784),
                  fontSize: 15,
                ),

                prefixIcon: const Icon(Icons.search, color: Color(0xff737784)),

                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: () {
                          _searchController.clear();
                          //????????
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                        icon: const Icon(Icons.close, color: Color(0xff737784)),
                      )
                    : null,

                filled: true,
                fillColor: const Color(0xffF1F3F7),

                contentPadding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 15,
                ),

                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),

                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: const BorderSide(
                    color: Color(0xff0A4FD6),
                    width: 1.2,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // -------------------------
            // SEARCH RESULTS
            // -------------------------
            if (isSearching)
              Expanded(
                child: StreamBuilder<List<BusinessModel>>(
                  stream: _searchService.searchBusinesses(_searchQuery),

                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Center(
                        child: Text(
                          "Something went wrong while searching.",
                          style: TextStyle(color: Color(0xff737784)),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final businesses = snapshot.data ?? [];

                    if (businesses.isEmpty) {
                      return _buildNoResults();
                    }

                    return ListView.builder(
                      itemCount: businesses.length,
                      itemBuilder: (context, index) {
                        final business = businesses[index];
                        print(businesses.length);
                        final distanceCal = business.getFormattedDistance(
                          userPosition,
                        );
                        return Column(
                          children: [
                            CategoryWidget(
                              category: business.category,
                              image: business.image,
                              businessName: business.name,
                              distance: "$distanceCal km",
                              rating: "${business.rating} ",
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => DetailsScreen(
                                      business: business,
                                      distanceText: "$distanceCal km",
                                    ),
                                  ),
                                );
                                // Handle tap event, e.g., navigate to business details
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              )
            // -------------------------
            // RECENT SEARCHES
            // -------------------------
            else ...[
              if (_recentSearches.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    const Text(
                      "Recent searches",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff171B26),
                      ),
                    ),

                    TextButton(
                      onPressed: _clearAllSearches,

                      child: const Text(
                        "Clear all",
                        style: TextStyle(
                          color: Color(0xff0A4FD6),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

              const SizedBox(height: 8),

              Expanded(
                child: _recentSearches.isEmpty
                    ? _buildEmptyState()
                    : ListView.separated(
                        itemCount: _recentSearches.length,

                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 10),

                        itemBuilder: (context, index) {
                          final search = _recentSearches[index];

                          return _buildRecentSearchTile(search);
                        },
                      ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearchTile(String search) {
    return Material(
      color: Colors.white,

      borderRadius: BorderRadius.circular(15),

      child: InkWell(
        borderRadius: BorderRadius.circular(15),

        onTap: () {
          _searchController.text = search;

          setState(() {
            _searchQuery = search;
          });
        },

        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(15),

            border: Border.all(color: const Color(0xffEAECEF)),
          ),

          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 3,
            ),

            leading: Container(
              width: 42,
              height: 42,

              decoration: BoxDecoration(
                color: const Color(0xffEEF3FF),
                borderRadius: BorderRadius.circular(12),
              ),

              child: const Icon(
                Icons.history,
                color: Color(0xff0A4FD6),
                size: 21,
              ),
            ),

            title: Text(
              search,

              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xff171B26),
              ),
            ),

            trailing: IconButton(
              onPressed: () {
                _removeSearch(search);
              },

              icon: const Icon(Icons.close, size: 19, color: Color(0xff737784)),
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // NO SEARCH RESULTS
  // ============================================================

  Widget _buildNoResults() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 80),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset('assets/images/search.png', height: 150),

            const SizedBox(height: 10),

            const Text(
              "No businesses found",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff171B26),
              ),
            ),

            const SizedBox(height: 7),

            Text(
              'We couldn\'t find anything for "$_searchQuery".',
              textAlign: TextAlign.center,

              style: const TextStyle(fontSize: 14, color: Color(0xff737784)),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // EMPTY RECENT SEARCHES
  // ============================================================

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 100),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          children: [
            Image.asset('assets/images/search.png', height: 180),

            const SizedBox(height: 10),

            const Text(
              "Start searching",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xff171B26),
              ),
            ),

            const SizedBox(height: 7),

            const Text(
              "Find businesses and places near you.",
              textAlign: TextAlign.center,

              style: TextStyle(fontSize: 14, color: Color(0xff737784)),
            ),
          ],
        ),
      ),
    );
  }
}
