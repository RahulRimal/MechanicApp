// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bato_mechanic/src/shared/widgets/async_value_widget.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/presentation/widgets/rating_stars_widget.dart';
import 'package:bato_mechanic/src/features/reviews_and_rating/presentation/widgets/reviews_and_rating_shimmer_widget.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/build_context_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/datetime_extensions.dart';
import 'package:bato_mechanic/src/shared/utils/helpers/user_helper.dart';
import 'package:bato_mechanic/src/shared/widgets/image_widget.dart';
import 'package:flutter/material.dart';

import 'package:bato_mechanic/src/features/reviews_and_rating/domain/reviews_and_rating/reviews_and_rating.dart';
import 'package:bato_mechanic/src/shared/utils/extensions/double_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../shared/utils/constants/managers/color_manager.dart';
import '../../../../shared/utils/constants/managers/values_manager.dart';
import '../../../../shared/repositories/user_repository/user_repository.dart';

class MechanicReviewWidget extends ConsumerWidget {
  const MechanicReviewWidget({
    Key? key,
    required this.review,
  }) : super(key: key);

  final ReviewAndRating review;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reviewerInfoValue =
        ref.watch(fetchUserInfoByUidxProvider(review.reviewerIdx));
    return AsyncValueWidget(
      loadingShimmer: const ReviewsAndRatingShimmerWidget(),
      value: reviewerInfoValue,
      data: (reviewer) => Container(
        padding: const EdgeInsets.all(AppPadding.p8),
        decoration: BoxDecoration(
            // border: isDarkTheme
            //     ? Border.all(color: ThemeColor.lightGrey)
            //     : Border.all(color: ThemeColor.grey),
            border: Border.all(color: ThemeColor.darkContainer),
            color: context.isDarkMode
                ? ThemeColor.transparent
                : ColorManager.primaryTint60,
            borderRadius: BorderRadius.circular(AppRadius.r8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: AppHeight.h20,
                        backgroundImage: reviewer.profilePic != null
                            ? ImageWidgetProvider(reviewer.profilePic!)
                            : const AssetImage(
                                'assets/images/no-profile.png',
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppPadding.p4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              UserHelperFunctions.getUserName(reviewer.name),
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                            RatingStarsWidget(rating: review.rating),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Text('2 days ago'.hardcoded()),
                Text(review.createdAt.toAgo()),
              ],
            ),
            const SizedBox(
              height: AppHeight.h8,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: Text(
                // 'Hello This is about Krishna who is a trained and professional mechanic with more dthan 10 years of experience',
                review.review,
                style: !context.isDarkMode
                    ? Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(color: ThemeColor.dark)
                    : Theme.of(context).textTheme.labelSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
